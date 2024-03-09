/* eslint-disable no-return-assign */
/* eslint-disable radix */
/* eslint-disable no-alert */
/* eslint-disable no-case-declarations */
/* eslint-disable no-unused-vars */
import { LightningElement, track } from 'lwc';

export default class Lwc_calculator extends LightningElement {
    @track result;

    
    handleCalculation(event) {
        const allValid = [...this.template.querySelectorAll('lightning-input'),].reduce((validSoFar, inputCmp) => {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);

        if (allValid) {
            const inputs = [...this.template.querySelectorAll('lightning-input')];
            let inputValues = [];
            inputs.forEach(element => {
                if (element.label !== 'Result') {
                    inputValues.push(parseInt(element.value));
                }
            });

            switch (event.target.label) {
                case 'Add':
                    const SumInitialValue = 0;
                    const sumWithInitial = inputValues.reduce(
                        (accumulator, currentValue) => accumulator + currentValue,
                        SumInitialValue);
                    this.result = sumWithInitial;
                    break;

                case 'Subtract':
                    const subWithInitial = inputValues.reduce(
                        (accumulator, currentValue) => accumulator - currentValue);
                    this.result = subWithInitial;
                    break;

                case 'Multiply':
                    const multiplyResult = inputValues.reduce(
                        (accumulator, currentValue) => accumulator * currentValue);
                    this.result = multiplyResult;
                    break;

                case 'Divide':
                    const divideResult = inputValues.reduce(
                        (accumulator, currentValue) => accumulator / currentValue);
                    this.result = divideResult;
                    break;

                case 'Reset':
                    const array1 = [...this.template.querySelectorAll('lightning-input')];
                    array1.forEach((element) => element.value = '');
                    break;

                default:
                    alert('Not a valid Operation');
            }
        }
    }
}