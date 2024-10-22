/**
 * @description       : Apex class controller Contacts
 * @author            : Juan David Sanchez Rey
 * @group             : Salesforce Team
 * @last modified on  : 21-10-2024
 * @last modified by  : 
**/
public with sharing class ContactManagementSystemController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        try {
            return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact];
        } catch (Exception e) {
            throw new AuraHandledException('Error al obtener la lista de contactos: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static Id createContact(Contact newContact) {
        if (newContact.Email == null || newContact.Email.isEmpty()) {
            throw new AuraHandledException('El campo de correo electrónico es obligatorio.');
        }
        try {
            insert newContact;
            return newContact.Id;
        } catch (DmlException e) {
            throw new AuraHandledException('Error al crear el contacto: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void updateContact(Contact updatedContact) {
        try {
            update updatedContact;
        } catch (DmlException e) {
            throw new AuraHandledException('Error al actualizar el contacto: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void deleteContacts(List<Id> contactIds) {
        try {
            delete [SELECT Id FROM Contact WHERE Id IN :contactIds];
        } catch (DmlException e) {
            throw new AuraHandledException('Error al eliminar los contactos: ' + e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm) {
        try {
            String searchPattern = '%' + searchTerm + '%';
            return [SELECT Id, FirstName, LastName, Email, Phone 
                    FROM Contact 
                    WHERE FirstName LIKE :searchPattern 
                       OR LastName LIKE :searchPattern 
                       OR Email LIKE :searchPattern];
        } catch (Exception e) {
            throw new AuraHandledException('Error al buscar contactos: ' + e.getMessage());
        }
    }
}