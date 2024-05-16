from fastapi import FastAPI

from . import models
from .database import SessionLocal, engine
from fastapi.middleware.cors import CORSMiddleware
from .router import login, user_doctor, user_patient

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(login.router)
app.include_router(user_doctor.router)
app.include_router(user_patient.router)


origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/")
async def root():
    return {"message": "Hello World"}



