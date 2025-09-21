import { LightningElement, api, track } from 'lwc';

export default class AccountCreateForm extends LightningElement {
    @api objectApiName = 'Account';
    @track accountId;
    @track newAccountCreated = false;
    @track showSpinner = false;

    handleRedirect() {
        this.showSpinner = true;
        this.newAccountCreated = false;
        this.showSpinner = false;
    }

    handleSubmit() {
        this.showSpinner = true;
        const allValid = [...this.template.querySelectorAll('lightning-input-field'),].reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        if (allValid) {
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
    }

    handleSuccess(event) {
        this.accountId = event.detail.id;
        this.newAccountCreated = true;
        this.showSpinner = false;
    }

    handleReset() {
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
}