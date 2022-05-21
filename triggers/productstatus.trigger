trigger productstatus on Product__c (after update) {

    List<Product__c> prod = [select id,Status__c,Name,Cost__c from Product__c where id in :Trigger.new];
    
    /*for(Product__c p1 : prod){
        system.debug(p1.Name + ' --- '+p1.Cost__c);
    }*/
    
    List<Product__c> updatedprod = new List<Product__c>();   // Empty List to store products to be deleted
    for(Product__c p : prod){
        if(p.Status__c == 'Rejected'){
            updatedprod.add(p);
        }
    }
    
    Delete updatedprod;
    
    
}