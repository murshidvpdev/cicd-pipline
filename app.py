from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def home():
    return {"message": "version 3"}


@app.get("/health")
def health():
    return {"status": "healthy"}