from fastapi import FastAPI

from . import models
from .database import SessionLocal, engine
from fastapi.middleware.cors import CORSMiddleware
from .router import  user_doctor, user_patient, visit
from . import auth

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(user_doctor.router)
app.include_router(user_patient.router)
app.include_router(auth.router)
app.include_router(visit.router)

origins = ['*']

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)




