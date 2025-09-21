/**
 * @description       : 
 * @author            : Deepak
 * @group             : 
 * @last modified on  : 12-16-2024
 * @last modified by  : Deepak
**/
import LightningDatatable from 'lightning/datatable';
import customPicture from './customPicture.html';
export default class CustomDataTypes extends LightningDatatable {
    static customTypes = {
        customPictureType: {
            template: customPicture,
            standardCellLayout: true,
            typeAttributes: ['pictureUrl']
        }
        // Other Custom Types
    };
}