import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactManagementSystemController.getContacts';
import searchContacts from '@salesforce/apex/ContactManagementSystemController.searchContacts';
import createContact from '@salesforce/apex/ContactManagementSystemController.createContact';
import deleteContacts from '@salesforce/apex/ContactManagementSystemController.deleteContacts';

const COLUMNS = [
    { label: 'Nombre', fieldName: 'FirstName', type: 'text', editable: true },
    { label: 'Apellido', fieldName: 'LastName', type: 'text', editable: true },
    { label: 'Correo Electrónico', fieldName: 'Email', type: 'email', editable: true },
    { label: 'Teléfono', fieldName: 'Phone', type: 'phone', editable: true },
    { type: 'action', typeAttributes: { rowActions: [{ label: 'Eliminar', name: 'delete' }] } }
];

export default class LWC_ContactManagementSystem extends LightningElement {
    @track contacts;
    @track draftValues = [];
    @track error;
    @track searchTerm = '';
    @track isModalOpen = false;
    @track newContact = { FirstName: '', LastName: '', Email: '', Phone: '' };

    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.contacts = undefined;
        }
    }

    handleSearchChange(event) {
        this.searchTerm = event.target.value;
        searchContacts({ searchTerm: this.searchTerm })
            .then(result => {
                this.contacts = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error.body.message;
                this.contacts = undefined;
            });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        if (actionName === 'delete') {
            this.deleteContact(row.Id);
        }
    }

    deleteContact(contactId) {
        deleteContacts({ contactIds: [contactId] })
            .then(() => {
                this.contacts = this.contacts.filter(contact => contact.Id !== contactId);
            })
            .catch(error => {
                this.error = error.body.message;
            });
    }

    handleNewContact() {
        this.isModalOpen = true;
        this.newContact = { FirstName: '', LastName: '', Email: '', Phone: '' };
    }

    handleModalCancel() {
        this.isModalOpen = false;
    }

    handleInputChange(event) {
        const field = event.target.dataset.id;
        this.newContact[field] = event.target.value;
    }

    handleModalSave() {
        createContact({ newContact: this.newContact })
            .then(result => {
                this.contacts = [...this.contacts, { ...this.newContact, Id: result }];
                this.isModalOpen = false;
                this.newContact = { FirstName: '', LastName: '', Email: '', Phone: '' };
            })
            .catch(error => {
                this.error = error.body.message;
            });
    }
}    