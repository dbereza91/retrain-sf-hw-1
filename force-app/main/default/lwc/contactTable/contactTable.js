import { LightningElement, track, wire } from 'lwc';

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
        var datatable = this.template.querySelector('lightning-datatable');
        var selected = datatable.getSelectedRows();
        var ids = [];
        for (var row in selected){
            ids.push(selected[row].id);
        }
        deleteContacts({ids: '$ids'}).catch(error => {
            console.error(error);
        });
        
    }
}   