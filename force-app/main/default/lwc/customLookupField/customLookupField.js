import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Type';


export default class CustomLookupField extends LightningElement {
    @api recordId; // The Customer record's ID
    @api objectApiName;

    fields = [ACCOUNT_NAME_FIELD, ACCOUNT_NUMBER_FIELD, ACCOUNT_TYPE_FIELD]

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Sucesso!!!',
            message: 'Atualização realizada com sucesso!!!',
            variant: 'success'
        });
        this.dispatchEvent(evt);
        
    }
}