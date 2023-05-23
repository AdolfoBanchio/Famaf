public class prueba2 {

    public static void main ( String [] args ){
        try{
            try{
                throw new Exception("excepcion del try interno");
            }catch (Exception e){
                System.out.println("catch interno manejando "+e.getMessage());
                throw new Exception("excepcion del catch interno");
            }finally{
                System.out.println("bloque finally del try interno");
                throw new Exception("excepcion del finally interno");
            }
        }catch(Exception e){
            System.out.println("catch externo manejando "+e.getMessage());
        }finally{
            System.out.println("bloque finally del try externo");
        }
    }
}

