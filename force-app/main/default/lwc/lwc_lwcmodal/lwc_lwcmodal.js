/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 11-30-2024
 * @last modified by  : Deepak
**/
import { LightningElement, track } from 'lwc';

export default class Lwc_lwcmodal extends LightningElement {
    @track isModalOpen = false;

    openModal() {
        this.isModalOpen = true;
    }

    handleModalClosure(){
        this.isModalOpen = false;
    }
}