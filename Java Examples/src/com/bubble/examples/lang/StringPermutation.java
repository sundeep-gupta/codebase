public class StringPermutation {
     String[] words = null;
     boolean skip[] = null;
     public StringPermutation(String[] words) {
         this.words = words;
         this.skip = new boolean[words.length];
     }
     public void printPermutation() {
         
         for(int i = 0; i < this.words.length; i++) {
             if(! this.skip[i]) {
                 System.out.print(this.words[i] + " ");
                 this.skip[i] = true;
                 printPermutation();
                 System.out.println();
                 this.skip[i] = false;
             }
         }

     }

     public static void main(String[] args) {

         StringPermutation sp = new StringPermutation(args);
         sp.printPermutation();
         System.out.println("---------- Sundeep");
     }

}
