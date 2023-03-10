@isTest
public class UpdateAccountRevenueBatchTest {
 private static Integer numOfAccounts =4;
  private static Integer numOfOrders = 10;
  private static Integer orderAmount = 150;
    @isTest
    static void testUpdateAccountRevenueBatch() {
// Insérer les données de test
        List<Account> accounts = DataFactoyTest.createAccounts(numOfAccounts);
       
        List<Order> orders = DataFactoyTest.createOrdersForAccounts(accounts, numOfOrders, orderAmount, 1);
     
        for (Order order : orders) {
                order.Status = 'Ordered';
            }
            update orders;

     // Met à jour la liste de commandes pour déclencher le batch 
        Test.startTest();
UpdateAccountRevenueBatch batch = new UpdateAccountRevenueBatch();
        Database.executeBatch(batch);
        update orders;
        Test.stopTest();
        // Vérifie que le nombre de commandes créées est égal à 40
        System.assertEquals(orders.size(), 40, 'the sum is');
      
    
    }
 @isTest
    static void testUpdateAccountRevenueBatchWithNoOrder() {
// Tester le cas limite : pas de commandes

        List<Account>  accounts = DataFactoyTest.createAccounts(numOfAccounts);
       List<Order> orders = DataFactoyTest.createOrdersForAccounts(accounts, 0, 0, 0);
        // Met à jour la liste de commandes pour déclencher le batch 
        Test.startTest();
UpdateAccountRevenueBatch batch = new UpdateAccountRevenueBatch();
        Database.executeBatch(batch);
       update orders;
        Test.stopTest();

        // Vérifie que le nombre de commandes créées est égal à 0
        System.assertEquals(orders.size(),0,'theres no order');
     
    }
    @isTest
  static void testExecuteMethode(){
// Insérer les données de test
List<Account> accounts = DataFactoyTest.createAccounts(numOfAccounts);
        List<Order> orders = DataFactoyTest.createOrdersForAccounts(accounts, numOfOrders, orderAmount, 1);
       
 for (Order order : orders) {
                order.Status = 'Ordered';
            }
            update orders;
        // Met à jour la liste de commandes pour déclencher le batch 
        Test.startTest();
        UpdateAccountRevenueBatch batch = new UpdateAccountRevenueBatch();
         // Exécute la classe batch
         Database.executeBatch(batch);
         update orders;

// Vérifier que le champ Chiffre_d_affaire__c a été mis à jour
        Account updatedAccount = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :accounts[0].Id];
        Decimal expectedRevenue =150;
        System.assertEquals(expectedRevenue, updatedAccount.Chiffre_d_affaire__c,'le chiffre d affaire egal a celui attendu ');
        Test.stopTest();
    }
}