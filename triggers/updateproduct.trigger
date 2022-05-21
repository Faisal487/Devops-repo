trigger updateproduct on Order__c (after update) {

     List<Order__c> odrs = [select Quantity__c,Product__r.Units_Available__c from Order__c where id in :Trigger.new];
    
     List<Product__c> p1 = new List<Product__c>();
     
    for(Order__c o1:odrs){
       Order__c old = (Order__c)Trigger.oldMap.get(o1.id);
        
        if(o1.Product__r.Units_Available__c >= (o1.Quantity__c - old.Quantity__c)){
               if(old.Quantity__c!=o1.Quantity__c){
                  
                   o1.Product__r.Units_Available__c += old.Quantity__c-o1.Quantity__c;
                   p1.add(o1.Product__r);                     
               }                                                                                                                     
        }else{
            Order__c o = Trigger.newMap.get(o1.id);        //Trigger.newMap.get(Order__c.id)
            o.addError('Out of Stock');
        }
        
    }
    update p1;          
}