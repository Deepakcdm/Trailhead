import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Contact.Account.Name'
import REVENUE_FIELD from '@salesforce/schema/Contact.Account.AnnualRevenue';
import CREATED_FIELD from '@salesforce/schema/Contact.Account.CreatedDate';

const fields = [REVENUE_FIELD, CREATED_FIELD, NAME_FIELD];
export default class LwcContactAccForm extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields })
    contact;

    get revenue() {
        return getFieldValue(this.contact.data, REVENUE_FIELD);
    }

    get created() {
        return getFieldValue(this.contact.data, CREATED_FIELD);
    }

    get Name() {
        return getFieldValue(this.contact.data, NAME_FIELD);
    }
}