from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal, get_db
from fastapi import APIRouter
from .. import schemas, crud

router = APIRouter(tags=["Doctor"],)


@router.post("/signup_doc/", response_model=schemas.Doctor)
def create_doctor(doctor: schemas.Doctor, db: Session = Depends(get_db)):
    return crud.create_doctor(db=db, doctor=doctor)

@router.post("/login_doc/")
def login_doctor(login_data: schemas.Doctor, db: Session = Depends(get_db)):
    doctor = crud.get_doctor_by_username(db, username=login_data.username)
    if not doctor or not crud.verify_password(login_data.password, doctor.password):
        raise HTTPException(status_code=400, detail="Invalid username or password")
    return {"Login Successfull"}


@router.get('/get_doctors')
def get_doctors(db: Session = Depends(get_db)):
    return crud.get_doctors(db=db)