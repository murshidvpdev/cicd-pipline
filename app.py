from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {"message": "hello ci cd"}


@app.get("/health")
def health():
    return {"status": "healthy"}