import { LightningElement,track} from 'lwc';

export default class Lwcexample3 extends LightningElement {
    @track contacts = [
        {
            Id: '003171a931112854375',
            Name: 'Amy Taylor',
            Title: 'VP of Engineering'
        },
        {
            Id: '003192301009134555',
            Name: 'Michael Jones',
            Title: 'VP of Sales'
        },
        {
            Id: '003848991274589432',
            Name: 'Jennifer Wu',
            Title: 'CEO'
        }
    ];
}