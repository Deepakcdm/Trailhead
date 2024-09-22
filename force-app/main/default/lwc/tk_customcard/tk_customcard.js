/* eslint-disable no-alert */
// wireGetRelatedListRecords.js
import { LightningElement, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from "@salesforce/schema/Question__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/Question__c.Description__c";
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';

export default class Tk_customcard extends NavigationMixin(LightningElement) {
    error;
    answers;
    questionId;
    fields = [DESCRIPTION_FIELD];
    @track likeState = false;
    @track dislikeState = false;

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.questionId = currentPageReference.attributes.recordId;
        }
    }

    @wire(getRecord, { recordId: "$questionId", layoutTypes: ["Full"], modes: ["View"] })
    questionRecord;


    get name() {
        return getFieldValue(this.questionRecord.data, NAME_FIELD);
    }

    get description() {
        return getFieldValue(this.questionRecord.data, DESCRIPTION_FIELD);
    }

    @wire(getRelatedListRecords, {
        parentRecordId: "$questionId",
        relatedListId: 'Answers__r',
        fields: ['Answer__c.Id', 'Answer__c.Name', 'Answer__c.Description__c', 'Answer__c.Rating__c'],
    })
    listInfo({ error, data }) {
        if (data) {
            this.answers = data.records;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.answers = undefined;
        }
    }

    get recordId() {
        return this.questionId;
    }

    handleQuestionEdit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.questionId, // pass the record id here.
                actionName: 'edit',
            },
        });
    }

    handleLikeButtonClick() {
        this.likeState = !this.likeState;
    }

    handleDislikeButtonClick() {
        this.dislikeState = !this.dislikeState;
    }

    handleAnswerEdit(event) {
        let answerId = event.currentTarget.dataset.id;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: answerId, // pass the record id here.
                actionName: 'edit',
            },
        });

    }
}