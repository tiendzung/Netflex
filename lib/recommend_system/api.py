from fastapi import APIRouter, FastAPI, HTTPException
from typing import List
import implicit
import pickle

# Define FastAPI app
app = FastAPI()

# Load the model
model = implicit.cpu.als.AlternatingLeastSquares.load('model.npz')

# Load data 
with open('preprocessed_data.pkl', 'rb') as f:
    sparse_matrix, user_ids, movie_ids = pickle.load(f)

def map_ix_to_id(ix, id_type):
    if id_type == 'user':
        mapping = {v: k for k, v in user_ids.items()}
    elif id_type == 'movie':
        mapping = {v: k for k, v in movie_ids.items()}
    else:
        raise ValueError("id_type must be either 'user' or 'movie'")
    return mapping[ix]

def map_id_to_ix(id, id_type):
    if id_type == 'user':
        return user_ids.get(id, None)
    elif id_type == 'movie':
        return movie_ids.get(id, None)
    else:
        raise ValueError("id_type must be either 'user' or 'movie'")

@app.get("/recommend/{user_id}")
def get_recommendation(user_id: str):
    user_ix = map_id_to_ix(user_id, 'user')
    print("user_ix: ", user_ix)
    if user_ix is None:
        raise HTTPException(status_code=404, detail="User ID not found")
    
    ids, _ = model.recommend(user_ix, sparse_matrix[user_ix], N=6, filter_already_liked_items=True)
    recs = [map_ix_to_id(id, 'movie') for id in ids]
    return recs

# This block ensures the script only runs when executed directly, not when imported
if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)