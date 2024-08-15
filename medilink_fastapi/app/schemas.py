from pydantic import BaseModel
from typing import Optional

class Doctor(BaseModel):
    username: str
    password: str

    class Config:
        orm_mode = True


class PatientCreate(BaseModel):
    username: str
    password: str
    confirm_password: Optional[str] = None

    class Config:
        orm_mode = True


class PatientData(BaseModel):
    dob: Optional[str] = None
    height: Optional[str] = None
    weight: Optional[str] = None

    class Config:
        orm_mode = True


class PatientLogin(BaseModel):
    username: str
    password: str

    class Config:
        orm_mode = True


class VisitCreate(BaseModel):
    patient_id: str
    weight: Optional[str] = None
    height: Optional[str] = None
    BP: Optional[str] = None
    Sugar: Optional[str] = None
    Symptoms: Optional[str] = None
    Disease: Optional[str] = None
    prescription: Optional[str] = None

    class Config:
        orm_mode = True

class Visit(VisitCreate):
    id: str


class BPData(BaseModel):
    bp: Optional[str] = None
    date: Optional[str] = None

    class Config:
        orm_mode = True