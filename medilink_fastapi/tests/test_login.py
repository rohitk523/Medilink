import pytest
from unittest.mock import patch
from fastapi import status

def test_generate_otp(client):
    test_number = {"contact_number": "+1234567890"}
    
    with patch('app.router.login.send_otp_via_sms') as mock_send_sms:
        response = client.post("/generate_otp/", json=test_number)
        assert response.status_code == status.HTTP_200_OK
        mock_send_sms.assert_called_once()

def test_login_with_otp(client):
    test_number = {"contact_number": "+1234567890"}
    test_otp = {"contact_number": "+1234567890", "otp": "123456"}
    
    # First generate OTP
    with patch('app.router.login.send_otp_via_sms'):
        client.post("/generate_otp/", json=test_number)
    
    # Mock the OTP verification
    with patch('app.router.login.users_db') as mock_db:
        mock_db.__getitem__.return_value = "123456"
        response = client.post("/login_with_otp/", json=test_otp)
        assert response.status_code == status.HTTP_200_OK

def test_invalid_otp(client):
    test_number = {"contact_number": "+1234567890"}
    test_otp = {"contact_number": "+1234567890", "otp": "wrong_otp"}
    
    # First generate OTP
    with patch('app.router.login.send_otp_via_sms'):
        client.post("/generate_otp/", json=test_number)
    
    # Test with invalid OTP
    with patch('app.router.login.users_db') as mock_db:
        mock_db.__getitem__.return_value = "123456"
        response = client.post("/login_with_otp/", json=test_otp)
        assert response.status_code == status.HTTP_401_UNAUTHORIZED