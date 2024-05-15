from pydantic import BaseModel

class Doctor(BaseModel):
    username: str
    password: str

    class Config:
        orm_mode = True


class Patient(BaseModel):
    name: str
    contact: str
    age: int
    city: str

    class Config:
        orm_mode = True