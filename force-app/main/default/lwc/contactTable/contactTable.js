import { LightningElement, track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import contacts from '@salesforce/apex/contactTable.fetchContacts';
import deleteContacts from '@salesforce/apex/contactTable.deleteContacts';

const COLUMNS = [
    { label: 'Contact Name', fieldName: 'name', type: 'text' },
    { label: 'Email', fieldName: 'email', type: 'text' },
    { label: 'Account Name', fieldName: 'accountName', type: 'text' }
];

export default class ContactTable extends LightningElement {
    @track columns = COLUMNS;
    @wire(contacts) parameters; 

    handleClick(event){
        var ids = [];   
        var datatable = this.template.querySelector('lightning-datatable');
        var selected = datatable.getSelectedRows();
        for (var row in selected){
            ids.push(selected[row].contactId);
        }
        deleteContacts({contactIds: ids}).then(() => {this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Records deleted ' + ids,
                variant: 'success'
                })
            );
            datatable.selectedRows = [];
            return refreshApex(this.parameters);
        })
        .catch(error => {
            console.error(error);
        });
    }
}