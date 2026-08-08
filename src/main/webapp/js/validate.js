// Lightweight CLIENT-SIDE validation for a nicer UX.
// This is a convenience layer ONLY - the server (servlets) always
// re-validates everything again, because client-side checks can be bypassed.

function showFieldError(input, message) {
    clearFieldError(input);
    const err = document.createElement('div');
    err.className = 'field-error';
    err.textContent = message;
    err.dataset.generated = 'true';
    input.insertAdjacentElement('afterend', err);
    input.style.borderColor = '#dc2626';
}

function clearFieldError(input) {
    input.style.borderColor = '';
    const next = input.nextElementSibling;
    if (next && next.dataset && next.dataset.generated === 'true') {
        next.remove();
    }
}

function isValidEmail(value) {
    return /^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$/.test(value);
}

function isValidPhone(value) {
    return /^(\+91[- ]?)?[6-9]\d{9}$/.test(value);
}

function isValidPassword(value) {
    return /^(?=.*[A-Za-z])(?=.*\d).{8,}$/.test(value);
}

function attachValidation(formId) {
    const form = document.getElementById(formId);
    if (!form) return;

    form.addEventListener('submit', function (e) {
        let valid = true;

        form.querySelectorAll('[data-validate]').forEach(function (input) {
            clearFieldError(input);
            const rule = input.dataset.validate;
            const value = input.value.trim();

            if (rule === 'required' && value === '') {
                showFieldError(input, 'This field is required.');
                valid = false;
            } else if (rule === 'email' && !isValidEmail(value)) {
                showFieldError(input, 'Enter a valid email address.');
                valid = false;
            } else if (rule === 'phone' && !isValidPhone(value)) {
                showFieldError(input, 'Enter a valid 10-digit mobile number.');
                valid = false;
            } else if (rule === 'password' && !isValidPassword(value)) {
                showFieldError(input, 'Min 8 characters, with a letter and a number.');
                valid = false;
            } else if (rule === 'date-not-future') {
                const today = new Date().toISOString().split('T')[0];
                if (value > today) {
                    showFieldError(input, 'Date cannot be in the future.');
                    valid = false;
                }
            }
        });

        // password confirmation match, if present on the form
        const pw = form.querySelector('[name="password"], [name="newPassword"]');
        const confirmPw = form.querySelector('[name="confirmPassword"]');
        if (pw && confirmPw && pw.value !== confirmPw.value) {
            showFieldError(confirmPw, 'Passwords do not match.');
            valid = false;
        }

        if (!valid) e.preventDefault();
    });
}
