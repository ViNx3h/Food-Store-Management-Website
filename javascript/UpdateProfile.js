/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


var fullNameInput = document.getElementById('fullName');
var fullNameError = document.getElementById('fullNameError');

fullNameInput.addEventListener('input', function () {
    var inputValue = fullNameInput.value;
    if (/[0-9]/.test(inputValue)) {
        fullNameError.innerHTML = 'Cannot use numbers.';
        fullNameInput.value = inputValue.replace(/[0-9]/g, '');
    } else if (/[^a-zA-Z\s]/.test(inputValue)) {
        fullNameError.innerHTML = 'Do not use special characters.';
        fullNameInput.value = inputValue.replace(/[^a-zA-Z\s]/g, '');
    } else {
        fullNameError.innerHTML = '';
    }
});

document.getElementById('birthday').addEventListener('change', function () {
    const birthday = new Date(this.value);
    const today = new Date();
    const age = today.getFullYear() - birthday.getFullYear();
    const monthDifference = today.getMonth() - birthday.getMonth();
    const dayDifference = today.getDate() - birthday.getDate();

    let actualAge = age;
    if (monthDifference < 0 || (monthDifference === 0 && dayDifference < 0)) {
        actualAge--;
    }
    const errorElement = document.getElementById('birthdayError');
    if (actualAge < 12) {
        errorElement.textContent = "You must be at least 12 years old.";
    } else {
        errorElement.textContent = "";
    }
});

var emailInput = document.getElementById('email');
var emailError = document.getElementById('emailError');
emailInput.addEventListener('input', function () {
    var inputValue = emailInput.value;

    if (!/@/.test(inputValue)) {
        emailError.innerHTML = 'Email must contain the character "@"';
        emailInput.value = inputValue.replace(/@/g, '');
    } else {
        emailError.innerHTML = '';
    }
});

var phoneInput = document.getElementById('phone');
var phoneError = document.getElementById('phoneError');
phoneInput.addEventListener('input', function () {
    var inputValue = phoneInput.value;
    if (!/^0|\d{9,10}$/.test(inputValue)) {
        phoneError.innerHTML = 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại bắt đầu bằng số 0 chỉ chứa số.';
        phoneInput.value = '';
    } else if (!/^\d*$/.test(inputValue)) {
        phoneError.innerHTML = 'Please enter numbers only.';
        phoneInput.value = '';
    } else {
        phoneError.innerHTML = '';
    }
});

var addressInput = document.getElementById('address');
var addressError = document.getElementById('addressError');
addressInput.addEventListener('input', function () {
    var inputValue = addressInput.value;
    if (/[0-9]/.test(inputValue)) {
        addressError.innerHTML = 'Cannot use numbers.';
        addressInput.value = inputValue.replace(/[0-9]/g, '');
    } else if (/[^a-zA-Z\s]/.test(inputValue)) {
        addressError.innerHTML = 'Do not use special characters.';
        addressInput.value = inputValue.replace(/[^a-zA-Z\s]/g, '');
    } else {
        addressError.innerHTML = '';
    }
});
        