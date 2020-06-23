import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import contacts from '@salesforce/apex/contactTable.fetchContacts';
import deleteContacts from '@salesforce/apex/contactTable.deleteContacts';

const columns = [{
    label: 'Name',
    fieldName: 'name'
    },
    {
    label: 'Email',
    fieldName: 'email'
    },
    {
    label: 'Account Name',
    fieldName: 'accountName'
    },
    ]

export default class ContactTable extends LightningElement {
    @track columns = columns;
    @wire(contacts) parameters; 

    handleClick(event){
        var ids = [];   
        var datatable = this.template.querySelector('lightning-datatable');
        var selected = datatable.getSelectedRows();
        for (var row in selected){
            ids.push(selected[row].contactId);
        }
        deleteContacts({ids: ids}).then(() => {this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Records deleted',
                variant: 'success'
                })
            );
        })
        .catch(error => {
            console.error(error);
        });
    }
}   