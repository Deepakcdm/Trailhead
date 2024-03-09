import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class lwc_editform extends NavigationMixin (LightningElement) {
  handlesuccess(event){
        const newRecordId= event.detail.id;
               // Navigate to the Newly created Page
              this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: newRecordId,
                    actionName: 'view'
                },
            });

            const evt = new ShowToastEvent({
                title: 'Toast Success',
                message: 'Account Created Successfully',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
    }
}