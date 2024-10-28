import pytest
from fastapi import status

def test_create_patient(client, test_patient):
    response = client.post("/signup_patient/", json=test_patient)
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["username"] == test_patient["username"]
    assert "password" not in response.json()

def test_create_duplicate_patient(client, test_patient):
    # Create first patient
    client.post("/signup_patient/", json=test_patient)
    
    # Try to create duplicate
    response = client.post("/signup_patient/", json=test_patient)
    assert response.status_code == status.HTTP_400_BAD_REQUEST

def test_add_patient_data(client, test_patient, auth_headers):
    patient_data = {
        "age": 30,
        "gender": "male",
        "medical_history": "None",
        "current_medications": "None",
        "allergies": "None"
    }
    
    response = client.post(
        f"/add_patient_data/{test_patient['username']}", 
        json=patient_data,
        headers=auth_headers
    )
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["age"] == patient_data["age"]
    assert response.json()["gender"] == patient_data["gender"]

def test_login_patient(client, test_patient):
    # First create a patient
    client.post("/signup_patient/", json=test_patient)
    
    # Try to login
    login_data = {
        "username": test_patient["username"],
        "password": test_patient["password"]
    }
    response = client.post("/login_patient/", json=login_data)
    assert response.status_code == status.HTTP_200_OK