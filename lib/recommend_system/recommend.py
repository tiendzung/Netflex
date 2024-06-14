import firebase_admin
from firebase_admin import credentials, db
import pandas as pd
import implicit
import scipy.sparse as sparse
import pickle
import schedule
import time

def connect_db(): 
    cred = credentials.Certificate("service-account-key.json")
    firebase_admin.initialize_app(cred, {
        'databaseURL': 'https://mobile-dzung-default-rtdb.asia-southeast1.firebasedatabase.app'
    })

def read_data(reference):
    ref = db.reference(reference)
    data = ref.get()
    print("Data read from database:", data)
    return data

def preprocess_data(data):
    rows = []

    user_ids = {old_id: new_id for new_id, old_id in enumerate(data.keys())}
    movie_ids = {}
    movie_counter = 0

    for user_data in data.values():
        for movie in user_data['rating'].keys():
            if movie not in movie_ids:
                movie_ids[movie] = movie_counter
                movie_counter += 1

    # Iterate through the data and create rows with new IDs
    for user_id, user_data in data.items():
        for movie, rating in user_data['rating'].items():
            rows.append({
                'user_ix': user_ids[user_id],
                'movie_ix': movie_ids[movie],
                'rating': rating
            })
    df = pd.DataFrame(rows)

    # Build the sparse matrix
    sparse_matrix = sparse.csr_matrix(
        (
            df.rating, (df.user_ix, df.movie_ix),
        )
    )
    return sparse_matrix, user_ids, movie_ids

training = False

def train_model(sparse_matrix): 
    global training
    training = True
    model = implicit.als.AlternatingLeastSquares(factors=50)
    model.fit(sparse_matrix)
    model.save('model.npz')
    training = False

def main():
    reference_path = 'list-users/'
    data = read_data(reference_path)

    sparse_matrix, user_ids, movie_ids = preprocess_data(data)
    with open('preprocessed_data.pkl', 'wb') as f:
        pickle.dump((sparse_matrix, user_ids, movie_ids), f)

    train_model(sparse_matrix) 

if __name__ == '__main__': 
    connect_db()
    main()

    # Schedule model training every 30 minute
    schedule.every(30).minutes.do(main)
    while True:
        schedule.run_pending()
        time.sleep(1)