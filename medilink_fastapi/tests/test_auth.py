import pytest
from fastapi import status

def test_create_access_token(client, test_patient):
    # First create a user
    response = client.post("/signup_patient/", json=test_patient)
    assert response.status_code == status.HTTP_200_OK
    
    # Test login
    response = client.post(
        "/token",
        data={
            "username": test_patient["username"],
            "password": test_patient["password"]
        }
    )
    assert response.status_code == status.HTTP_200_OK
    assert "access_token" in response.json()
    assert response.json()["token_type"] == "bearer"

def test_get_current_user(client, test_patient, auth_headers):
    response = client.get("/users/me", headers=auth_headers)
    assert response.status_code == status.HTTP_200_OK
    assert response.json()["username"] == test_patient["username"]

def test_invalid_token(client):
    response = client.get(
        "/users/me",
        headers={"Authorization": "Bearer invalid_token"}
    )
    assert response.status_code == status.HTTP_401_UNAUTHORIZED

def test_missing_token(client):
    response = client.get("/users/me")
    assert response.status_code == status.HTTP_401_UNAUTHORIZED