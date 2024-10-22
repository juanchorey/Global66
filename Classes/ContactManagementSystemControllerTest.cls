/**
 * @description       : Apex class test
 * @author            : Juan David Sanchez
 * @group             : Salesforce Team
 * @last modified on  : 21-10-2024
 * @last modified by  : 
**/
@isTest
public class ContactManagementSystemControllerTest {
    
    @testSetup
    static void setup() {
        // Creo conctactos de prueba aunque deberia esta una testdatafactory
        List<Contact> testContacts = new List<Contact>{
            new Contact(FirstName = 'Juan', LastName = 'Sanchez', Email = 'Juan.Sanchez@hotmail.com', Phone = '3124465190'),
            new Contact(FirstName = 'David', LastName = 'Sanchez', Email = 'David.Sanchez@hotmail.com', Phone = '3118654930')
        };
        insert testContacts;
    }
    
    @isTest
    static void testGetContacts() {
        Test.startTest();
        List<Contact> contacts = ContactManagementSystemController.getContacts();
        Test.stopTest();
        //uso la nueva definicion de assertAreNotEqual
        System.assertAreNotEqual(0, contacts.size(), 'Debe devolver al menos un contacto');
        System.assertAreNotEqual(null, contacts[0].Email, 'El campo Email no debe ser nulo');
    }
    
    @isTest
    static void testCreateContact() {
        // Crear un contacto válido
        Contact newContact = new Contact(FirstName = 'Alice', LastName = 'Johnson', Email = 'alice.johnson@example.com', Phone = '1231231234');
        
        Test.startTest();
        Id contactId = ContactManagementSystemController.createContact(newContact);
        Test.stopTest();
        //uso la nueva definicion de assertAreNotEqual
        System.assertAreNotEqual(null, contactId, 'El ID del contacto creado no debe ser nulo');
        
    }
    
    @isTest
    static void testCreateContactWithoutEmail() {
        // Intentar crear un contacto sin correo electrónico
        Contact newContact = new Contact(FirstName = 'NoEmail', LastName = 'Test');
        
        Test.startTest();
        try {
            ContactManagementSystemController.createContact(newContact);
            System.assert(false, 'Debería lanzarse una excepción al crear un contacto sin correo electrónico');
        } catch (AuraHandledException e) {
            System.assert(e.getMessage().contains('El campo de correo electrónico es obligatorio.'), 'El mensaje de error no es el esperado');
        }
        Test.stopTest();
    }
    
    @isTest
    static void testUpdateContact() {
        // Obtener un contacto de prueba y actualizar su información
        Contact existingContact = [SELECT Id, LastName FROM Contact LIMIT 1];
        existingContact.LastName = 'UpdatedLastName';
        
        Test.startTest();
        ContactManagementSystemController.updateContact(existingContact);
        Test.stopTest();
        
        Contact updatedContact = [SELECT Id, LastName FROM Contact WHERE Id = :existingContact.Id];
        System.assertEquals('UpdatedLastName', updatedContact.LastName, 'El apellido del contacto no se actualizó correctamente');
    }
    
    @isTest
    static void testDeleteContacts() {
        List<Contact> contactsToDelete = [SELECT Id FROM Contact LIMIT 2];
        List<Id> contactIds = new List<Id>();
        for (Contact c : contactsToDelete) {
            contactIds.add(c.Id);
        }
        
        Test.startTest();
        ContactManagementSystemController.deleteContacts(contactIds);
        Test.stopTest();
        
        Integer deletedCount = [SELECT COUNT() FROM Contact WHERE Id IN :contactIds];
        System.assertEquals(0, deletedCount, 'Los contactos no se eliminaron correctamente');
    }
    
    @isTest
    static void testSearchContacts() {
        Test.startTest();
        List<Contact> results = ContactManagementSystemController.searchContacts('David');
        Test.stopTest();
        
        System.assertAreNotEqual(0, results.size(), 'Debe devolver al menos un resultado para la búsqueda "David"');

    }
}