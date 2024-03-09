import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const fields = [
    'Contact.Name',
    'Contact.Company__c',
    'Contact.Phone',
    'Contact.Email'
];

export default class WireGetRecordDynamicContact extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    contact;

    get name() {
        return this.contact.data.fields.Name.value;
    }

    get company() {
        return this.contact.data.fields.Company__c.value;
    }

    get phone() {
        return this.contact.data.fields.Phone.value;
    }

    get email() {
        return this.contact.data.fields.Email.value;
    }
}