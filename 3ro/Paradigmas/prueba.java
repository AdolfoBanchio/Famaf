class Program {
    
    public static void main ( String [] args) {
    try {
        try {
            throw new Exception ("exception thrown from tryblock") ;
        }
        catch ( Exception ex ) {            
            System.out.printf("\nInner catch handling {0}.\n"+ ex.getMessage()+"\n");
        }
        finally {
            System.out.println ("Inner finally block");
        }
     }
     catch ( Exception ex ) {
        System.out.printf ( "Outer catch block handling { 0 } ." , ex.getMessage()) ;
     }
     finally {
        System.out.println ( "Outer finally block" ) ;
     }
    }
}