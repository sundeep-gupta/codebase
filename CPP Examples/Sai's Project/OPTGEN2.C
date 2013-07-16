/*HANUMANTH GOPAL CHIVKULA VENKATA VISHWANATH
STUDENT # 012128715
Course : CS6320
email : hcmc2@studentmail.umsl.edu */

#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<conio.h>
#include<string.h>
#include<math.h>

#define N 100
#define ROWS 100
#define COLS 4
#define NUMRUNS 1

/* distance : Calculate the distance between the two double arrays
 * Paramters : double *cluster and double *irisPoint, the double arrays upon
 *		which the distance is calculated.
 * Return :    a double value indicating the distance between two points
 */
double distance(double *cluster, double *irisPoint) {
double distanceVal=0.0;
    distanceVal = sqrt( pow((cluster[0]-irisPoint[0]),2) + pow((cluster[1]-irisPoint[1]),2)+ pow((cluster[2]-irisPoint[2]),2)+ pow((cluster[3]-irisPoint[3]),2) );
    return distanceVal;
}
/* retFinFit : calculates the fitness of two arrays
 * Parameters : double *fitIndex1, double *fitIndex2
 *		Values upon which the fitness value is calculated
 *		int len - max length of the fitness paraeters
 * Return :	A fitness index
 */
double retFinFit(double *fitIndex1,double *fitIndex2, int len) {
double irisData[150][4] = {
    {5.1,3.5,1.4,0.2}, {4.9,3.0,1.4,0.2}, {4.7,3.2,1.3,0.2}, {4.6,3.1,1.5,0.2}, {5.0,3.6,1.4,0.2},
    {5.4,3.9,1.7,0.4}, {4.6,3.4,1.4,0.3}, {5.0,3.4,1.5,0.2}, {4.4,2.9,1.4,0.2}, {4.9,3.1,1.5,0.1},
    {5.4,3.7,1.5,0.2}, {4.8,3.4,1.6,0.2}, {4.8,3.0,1.4,0.1}, {4.3,3.0,1.1,0.1}, {5.8,4.0,1.2,0.2},
    {5.7,4.4,1.5,0.4}, {5.4,3.9,1.3,0.4}, {5.1,3.5,1.4,0.3}, {5.7,3.8,1.7,0.3}, {5.1,3.8,1.5,0.3},
    {5.4,3.4,1.7,0.2}, {5.1,3.7,1.5,0.4}, {4.6,3.6,1.0,0.2}, {5.1,3.3,1.7,0.5}, {4.8,3.4,1.9,0.2},
    {5.0,3.0,1.6,0.2}, {5.0,3.4,1.6,0.4}, {5.2,3.5,1.5,0.2}, {5.2,3.4,1.4,0.2}, {4.7,3.2,1.6,0.2},
    {4.8,3.1,1.6,0.2}, {5.4,3.4,1.5,0.4}, {5.2,4.1,1.5,0.1}, {5.5,4.2,1.4,0.2}, {4.9,3.1,1.5,0.1},
    {5.0,3.2,1.2,0.2}, {5.5,3.5,1.3,0.2}, {4.9,3.1,1.5,0.1}, {4.4,3.0,1.3,0.2}, {5.1,3.4,1.5,0.2},
    {5.0,3.5,1.3,0.3}, {4.5,2.3,1.3,0.3}, {4.4,3.2,1.3,0.2}, {5.0,3.5,1.6,0.6}, {5.1,3.8,1.9,0.4},
    {4.8,3.0,1.4,0.3}, {5.1,3.8,1.6,0.2}, {4.6,3.2,1.4,0.2}, {5.3,3.7,1.5,0.2}, {5.0,3.3,1.4,0.2},
    {7.0,3.2,4.7,1.4}, {6.4,3.2,4.5,1.5}, {6.9,3.1,4.9,1.5}, {5.5,2.3,4.0,1.3}, {6.5,2.8,4.6,1.5},
    {5.7,2.8,4.5,1.3}, {6.3,3.3,4.7,1.6}, {4.9,2.4,3.3,1.0}, {6.6,2.9,4.6,1.3}, {5.2,2.7,3.9,1.4},
    {5.0,2.0,3.5,1.0}, {5.9,3.0,4.2,1.5}, {6.0,2.2,4.0,1.0}, {6.1,2.9,4.7,1.4}, {5.6,2.9,3.6,1.3},
    {6.7,3.1,4.4,1.4}, {5.6,3.0,4.5,1.5}, {5.8,2.7,4.1,1.0}, {6.2,2.2,4.5,1.5}, {5.6,2.5,3.9,1.1},
    {5.9,3.2,4.8,1.8}, {6.1,2.8,4.0,1.3}, {6.3,2.5,4.9,1.5}, {6.1,2.8,4.7,1.2}, {6.4,2.9,4.3,1.3},
    {6.6,3.0,4.4,1.4}, {6.8,2.8,4.8,1.4}, {6.7,3.0,5.0,1.7}, {6.0,2.9,4.5,1.5}, {5.7,2.6,3.5,1.0},
    {5.5,2.4,3.8,1.1}, {5.5,2.4,3.7,1.0}, {5.8,2.7,3.9,1.2}, {6.0,2.7,5.1,1.6}, {5.4,3.0,4.5,1.5},
    {6.0,3.4,4.5,1.6}, {6.7,3.1,4.7,1.5}, {6.3,2.3,4.4,1.3}, {5.6,3.0,4.1,1.3}, {5.5,2.5,4.0,1.3},
    {5.5,2.6,4.4,1.2}, {6.1,3.0,4.6,1.4}, {5.8,2.6,4.0,1.2}, {5.0,2.3,3.3,1.0}, {5.6,2.7,4.2,1.3},
    {5.7,3.0,4.2,1.2}, {5.7,2.9,4.2,1.3}, {6.2,2.9,4.3,1.3}, {5.1,2.5,3.0,1.1}, {5.7,2.8,4.1,1.3},
    {6.3,3.3,6.0,2.5}, {5.8,2.7,5.1,1.9}, {7.1,3.0,5.9,2.1}, {6.3,2.9,5.6,1.8}, {6.5,3.0,5.8,2.2},
    {7.6,3.0,6.6,2.1}, {4.9,2.5,4.5,1.7}, {7.3,2.9,6.3,1.8}, {6.7,2.5,5.8,1.8}, {7.2,3.6,6.1,2.5},
    {6.5,3.2,5.1,2.0}, {6.4,2.7,5.3,1.9}, {6.8,3.0,5.5,2.1}, {5.7,2.5,5.0,2.0}, {5.8,2.8,5.1,2.4},
    {6.4,3.2,5.3,2.3}, {6.5,3.0,5.5,1.8}, {7.7,3.8,6.7,2.2}, {7.7,2.6,6.9,2.3}, {6.0,2.2,5.0,1.5},
    {6.9,3.2,5.7,2.3}, {5.6,2.8,4.9,2.0}, {7.7,2.8,6.7,2.0}, {6.3,2.7,4.9,1.8}, {6.7,3.3,5.7,2.1},
    {7.2,3.2,6.0,1.8}, {6.2,2.8,4.8,1.8}, {6.1,3.0,4.9,1.8}, {6.4,2.8,5.6,2.1}, {7.2,3.0,5.8,1.6},
    {7.4,2.8,6.1,1.9}, {7.9,3.8,6.4,2.0}, {6.4,2.8,5.6,2.2}, {6.3,2.8,5.1,1.5}, {6.1,2.6,5.6,1.4},
    {7.7,3.0,6.1,2.3}, {6.3,3.4,5.6,2.4}, {6.4,3.1,5.5,1.8}, {6.0,3.0,4.8,1.8}, {6.9,3.1,5.4,2.1},
    {6.7,3.1,5.6,2.4}, {6.9,3.1,5.1,2.3}, {5.8,2.7,5.1,1.9}, {6.8,3.2,5.9,2.3}, {6.7,3.3,5.7,2.5},
    {6.7,3.0,5.2,2.3}, {6.3,2.5,5.0,1.9}, {6.5,3.0,5.2,2.0}, {6.2,3.4,5.4,2.3}, {5.9,3.0,5.1,1.8}
};
int i,cluster1Size,cluster2Size,d;
double x1, x2, x3, finalFitness = 0.0,dist1,dist2;
double cluster1[150][4], cluster2[150][4];
double cent1[] = {0.0,0.0,0.0,0.0}, cent2[4] = {0.0,0.0,0.0,0.0};
double scatter1 = 0.0, scatter2 = 0.0;
double clusterDistance = 0.0;

    cluster2Size=0;
    cluster1Size=0;
    for(i=0;i<150;i++) {
	dist1 = distance(fitIndex1,irisData[i]);
	dist2 = distance(fitIndex2,irisData[i]);
	if(dist1<dist2)	{
	    for(d=0;d<4;d++) {
		cluster1[cluster1Size][d] = irisData[i][d];
		cent1[d] += cluster1[cluster1Size][d];
	    }
	    cluster1Size++;
	} else {
	    for(d=0;d<4;d++) {
		cluster2[cluster2Size][d] = irisData[i][d];
		cent2[d] += cluster2[cluster2Size][d];
	    }
	    cluster2Size++;
	}
    }
    if(cluster1Size != 0) {
	cent1[0] = cent1[0]/cluster1Size;
	cent1[1] = cent1[1]/cluster1Size;
	cent1[2] = cent1[2]/cluster1Size;
	cent1[3] = cent1[3]/cluster1Size;
    }
    if(cluster2Size !=0) {
	cent2[0] = cent2[0]/cluster2Size;
	cent2[1] = cent2[1]/cluster2Size;
	cent2[2] = cent2[2]/cluster2Size;
	cent2[3] = cent2[3]/cluster2Size;
    }
    for(i=0;i<cluster1Size;i++) {
	scatter1 = scatter1+distance(cluster1[i],cent1);
    }
    for(i=0;i<cluster2Size;i++) {
	scatter2 = scatter2+distance(cluster2[i],cent2);
    }
    clusterDistance = distance(cent1,cent2);
    finalFitness = (scatter1+scatter2)/clusterDistance;
    return finalFitness;
}
/*
 * MaxFinalFitness : Calculates the maximum value in double *fitnessValues,
 *		     between the m-20 and m
 * Parameters : double *fitnessValues, double array from which the max number
 *		is to be found.
 *		int m - Number specifying the range in which the Max value is to be found.
 * Return : a double value indicating the max value.
 */
double MaxFinalFitness(double * fitnessValues,int m) {
int initial = m-20;
int final   = m;
int i;
double maxFitnessVal = fitnessValues[initial];
    for(i=initial+1;i<final;i++) {
	if(maxFitnessVal<fitnessValues[i])
	    maxFitnessVal = fitnessValues[i];
    }
  return maxFitnessVal;
}

/* 
 * Main program starts here
 */
int main() {
  double x,mean;

  int a,b,c,i,j,k,l,numGen,m,n,nor,d;

  /* Main variables */
  double norFinalFitness[NUMRUNS],finalFitnessVals[1000],fitnessVals[ROWS],r,f=0.8;

  /* Temporary variable declarations */
  double temp[2][ROWS][COLS],finalPop[2][ROWS][COLS],temp1[2][COLS],new[2][COLS],temps[2][COLS];
  int norNumGen[NUMRUNS],avgGen=0;
  double oldfit, fitness=0.0,finalFitness=0.0,angle;
  clock_t start, end;
  double cpu_time_used;
  /* Save the time when the program started */
  start = clock();
  clrscr();

  /* Randomize the Random number generator */
  srand((unsigned)time(NULL));
  /* Each Run Starts Here */
  for(nor=0;nor<NUMRUNS;nor++) {
     /* Initialize temp[][] with some random values */	  
     for(d=0;d<2;d++) {
	 for(i=0;i<ROWS;i++) {
	     for(j=0;j<COLS;j++) {
	         x= (float) (rand() / (RAND_MAX+1.0)); /* The number is a float value between 0 and 1 */
		 temp[d][i][j]=x;
	     }
	 }
     }
     numGen = 0;
     i = 0;
     finalFitness = retFinFit(temp[0][i],temp[1][i],COLS);
     while(finalFitness > 0.001 && numGen < 200) {
	  printf(".");
	  for(i=0;i<ROWS;i++) {
	      fflush(stdin);
	      oldfit  = 0.0;
	      fitness = 0.0;

	      /* Below three loops will select four numbers (i, a, b, c ) randomly such that, i <> a <> b <> c */
	      a=i;
	      do {
		  a=(float) N * rand()/ (RAND_MAX);
	      }while(a==i);
	      b=i;
	      do {
		  b=(float) N * rand()/ (RAND_MAX);
	      }while(b==i || b==a);
	      c=i;
	      do {
		   c=(float) N * rand()/ (RAND_MAX);
	      } while(c==i || c==a || c==b);

	      /* Calculate the fitness of the temp[0][i],temp[1][i] & store it in variable */
	      oldfit = retFinFit(temp[0][i],temp[1][i],COLS);
	      /*
	       * Calculate some value using the unique random numbers selected in previous loop
	       * and then store them in another temporary array
	       */
	      for(d=0;d<2;d++) {
		  for(j=0;j<COLS;j++) {
		      temp1[d][j] = temp[d][a][j] + f*(temp[d][b][j] - temp[d][c][j]);
		  }
	      }
	      /*
	       * Whatever values we get in temp1 array in earlier loop
	       * Store them in another array temps[][] if we get a random value < 0.8
	       * if random value is >= 0.8 then use fourth unique number (i) and store temp[d][i][j] in the tems[][]
	       */
	      for(d=0;d<2;d++) {
		  for(j=0;j<COLS;j++) {
		      temps[d][j]=((double) 1* rand()/ (RAND_MAX)<0.8)?temp1[d][j]:temp[d][i][j];
		  }
	      }
	      /* Calculate the fitness of the temps[0],temps[1] & store it in variable */
	      fitness = retFinFit(temps[0],temps[1],COLS);

	      /*
	       * Now compare fitness of temp[x][i] with temps[x] {x = 0 & 1 }
	       * If temp[] is more fit then save it's values into new[][] otherwise save temps[]'s values
	       */
	      if(oldfit<fitness) {
		  for(d=0;d<2;d++) {
			for(j=0;j<COLS;j++) {
			    finalPop[d][i][j]=temp[d][i][j];
			}
		   }
	      } else {
		   for(d=0;d<2;d++) {
			for(j=0;j<COLS;j++) {
			    finalPop[d][i][j]=temps[d][j];
			}
		   }
	       }
	   } /* END of for(i<ROWS) loop */

	   for(j=0;j<ROWS;j++) {
		fitnessVals[j]=0;
	   }
	   /* Now calculate the final fitneess using the finalPop[][] array */
	   for(j=0;j<ROWS;j++) {
		fitnessVals[j] = retFinFit(finalPop[0][j],finalPop[1][j],COLS);
	   }
	   /* Among the array of final fitness values find the greatest <FITTEST> one */
	   finalFitness = fitnessVals[0];
	   for(j=1;j<ROWS;j++) {
	       if(finalFitness>fitnessVals[j])
		   finalFitness = fitnessVals[j];
	   }
	   for(d=0;d<2;d++) {
	       for(j=0;j<ROWS;j++) {
		   for(k=0;k<COLS;k++)
		       temp[d][j][k] = finalPop[d][j][k];
		   }
	       }
	       finalFitnessVals[numGen] = finalFitness;
	       numGen++;
	   }
	   /*
	    * If it is the first run then ....
	    *
	    */
	   if(nor == 0) {
	       printf("::Output for First Run::\n");
	       printf("\nMaxFitness   GenerationNumber  MinFinalFitness \n");
	       printf("*****************************************\n");
	       for(m=1;m<numGen;m++) {
		   if(m%20 == 0){
			printf("%lf \t %d \t\t %lf \n",MaxFinalFitness(finalFitnessVals,m),m,finalFitnessVals[m]);
		   }
	       }
//	       getch();
//	       clrscr();
	  } /* End of IF */
	  norFinalFitness[nor] = finalFitness;
	  norNumGen[nor]=numGen;
	  /* Each Run Ends Here*/
      }/* Closing All Run For*/
      printf("\nTotal Number of clusters used are : 2");
      printf("\n Fitness and Total Generations for the %d runs: \n\n",NUMRUNS);
      for(m=0;m<NUMRUNS;m++) {
	  printf("\n Final Fitness: \t %lf \t Total Generations: \t %d \t",norFinalFitness[m],norNumGen[m]);
      }
      for(m=0;m<NUMRUNS;m++) {
	  avgGen+=norNumGen[m];
      }
      printf("\n\n Average Number of Genrations are: \t %d  ", (avgGen)/NUMRUNS);

  end = clock();
  cpu_time_used = ((double) (end - start));
  printf("\nCPU time used is:: \t \t \t %lf  ", cpu_time_used);
  getch();
  return 0;
}
