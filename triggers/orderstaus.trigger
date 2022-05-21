trigger orderstaus on Order__c (after update) {
   
    List<Order__c> oder = [select id,Status__c from Order__c where id in: Trigger.new];
    
    List<Order__c>o3 = new List<Order__c>();
    for(Order__c o4:oder){
        if(o4.Status__c == 'Cancelled'){
            o3.add(o4);
        }
    }
    Delete o3;    
}