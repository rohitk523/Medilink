from sqlalchemy import Boolean, Column, ForeignKey, Integer, String
from sqlalchemy.orm import relationship
import uuid
from .database import Base

class Doctor(Base):
    __tablename__ = "doctors"

    id = Column(Integer, primary_key=True)
    username = Column(String, unique=True, index=True)
    password = Column(String)


class Patient(Base):
    __tablename__ = "patients"
    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    username = Column(String, unique=True, index=True)
    password = Column(String)
    dob = Column(String, nullable=True)   # Allow NULL values
    height = Column(String, nullable=True) # Allow NULL values
    weight = Column(String, nullable=True) # Allow NULL values

    # Relationship to visits
    visits = relationship("Visit", back_populates="patient")


class Visit(Base):
    __tablename__ = "visits"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid.uuid4()))
    patient_id = Column(String, ForeignKey("patients.id"), nullable=False)
    weight = Column(String, nullable=True)
    height = Column(String, nullable=True)
    BP = Column(String, nullable=True)
    Sugar = Column(String, nullable=True)
    Symptoms = Column(String, nullable=True)
    Disease = Column(String, nullable=True)
    prescription = Column(String, nullable=True)

    patient = relationship("Patient", back_populates="visits")