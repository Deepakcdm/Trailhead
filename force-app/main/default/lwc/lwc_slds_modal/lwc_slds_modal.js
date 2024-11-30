/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 11-30-2024
 * @last modified by  : Deepak
**/
import { LightningElement, track } from 'lwc';

export default class Lwc_slds_modal extends LightningElement {
    @track isModalOpen = false;

    handleModalClosure() {
        this.isModalOpen = false;
    }

    openModal() {
        this.isModalOpen = true;
    }
}