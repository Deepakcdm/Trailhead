import { LightningElement } from 'lwc';


export default class TestDynamicComponent extends LightningElement {

    buttonAttributes = {
        "label": "save",
        "name": "Save Button",
        "variant": "success"
    };

    inputAttributes = {
        "type": "number",
        "label": "Enter a number between 10 and 20",
        "placeholder": "Enter a number",
        "max": 20,
        "min": 10,
        "step": 2,
        "value": "15",
        "name": "Number Field",
        "required": true,
        "disabled": false,
        "readonly": false
    }

    renderedCallback() {
        if (this.buttonAttributes) {
            const buttonElement = this.template.querySelector('lightning-button');
            if (buttonElement) {
                Object.keys(this.buttonAttributes).forEach(key => {
                    buttonElement[key] = this.buttonAttributes[key];
                });
            }
        }

        if (this.inputAttributes) {
            const inputElement = this.template.querySelector('lightning-input');
            if (inputElement) {
                Object.keys(this.inputAttributes).forEach(key => {
                    inputElement[key] = this.inputAttributes[key];
                });
            }
        }
    }
}