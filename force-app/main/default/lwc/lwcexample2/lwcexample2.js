import { LightningElement,track } from 'lwc';

export default class Lwcexample2 extends LightningElement {
@track detailsvisible = false;

renderinfo(event)
{
    this.detailsvisible=event.target.checked;
}
}