public class BatchApexOrnek implements Database.Batchable<sObject> , Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        // ilk yontem 
       // String query = 'select id , name FROM account Where name like \'AAA%\' ';
        
        // ikinci yontem
       // string ad= 'AAA%'
      //  String query = 'select id , name FROM account Where name like ' + ad +' ' ;
        return Database.getQueryLocator(([SELECT Id,name, guncellenme_Sirasi__c FROM Account WHERE name Like 'AAA%']) );
    }
    integer sayi = 1 ;
    public void execute(Database.BatchableContext BC, List<Account> accList) {
       
        List<Contact> cntList = new List<Contact>();
        // process each batch of records default size is 200
        for(Account acc : accList) {
            
            acc.name = acc.name + ' stateful';
            acc.guncellenme_Sirasi__c = sayi;
            sayi = sayi +1 ;
            /* for(Contact cnt : acc.Contacts){
                cnt.MailingCountry = acc.BillingCountry;
               cntList.add(cnt);
            }*/
        }
        try {
            // Update the Account Record
          //  update cntList;
          update accList;
         
        } catch(Exception e) {
            System.debug(e);
        }
         
    }   
     
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
    
    
}