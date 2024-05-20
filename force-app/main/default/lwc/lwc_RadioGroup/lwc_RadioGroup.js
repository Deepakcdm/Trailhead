import { LightningElement } from 'lwc';

export default class Lwc_RadioGroup extends LightningElement {
    value = '';

    get options() {
        return [
            { label: 0, value: 'option1' },
            { label: 1, value: 'option2' },
        ];
    }

    renderedCallback() {
        // Create a style element
        const styleElement = document.createElement('style');
        // Set your CSS rules
        const css = `
            .radioStyle .slds-form-element__control .slds-radio {
                display: inline-block !important;
            }
        `;
        // Set the CSS rules to the style element
        styleElement.textContent = css;
        // Append the style element to the component's shadow root
        this.template.appendChild(styleElement);
    }
}