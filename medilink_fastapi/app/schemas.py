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

class PatientLogin(BaseModel):
    username: str
    password: str

    class Config:
        orm_mode = True

