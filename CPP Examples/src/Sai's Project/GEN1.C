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


double irisData[150][4];
double distance(double *cluster, double *irisPoint) {
double distanceVal=0.0;
    distanceVal = sqrt( pow((cluster[0]-irisPoint[0]),2) + pow((cluster[1]-irisPoint[1]),2)+ pow((cluster[2]-irisPoint[2]),2)+ pow((cluster[3]-irisPoint[3]),2) );
    return distanceVal;
}
double retFinFit(double *fitIndex1,double *fitIndex2, int len) {
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

int main() {
  double x,mean;

  int a,b,c,i,j,k,l,numGen,m,n,nor,d;


  double norFinalFitness[NUMRUNS],finalFitnessVals[1000],fitnessVals[ROWS],r,f=0.8;


  double temp[2][ROWS][COLS],finalPop[2][ROWS][COLS],temp1[2][COLS],new[2][COLS],temps[2][COLS];
  int norNumGen[NUMRUNS],avgGen=0;
  double oldfit, fitness=0.0,finalFitness=0.0,angle;
  clock_t start, end;
  double cpu_time_used;

  FILE *fp = fopen("IRIS.dat","r");
  float dou = 0;
  int ch, index = -1,cnt = 0;
  char *str;
  if(fp == NULL)
      exit(0);

  do {
      while((ch = getc(fp)) != '\n' && ch != ',' && ch != EOF && ch !='{' && ch!= '}' && ch!= '\t')
	  str[++index] = ch;
      str[++index] = '\0';
      dou = atof(str);
      irisData[cnt/4][cnt%4] = atof(str);
      cnt++;
      index = -1;
  } while(ch!=EOF);



  start = clock();
  clrscr();
  
  
  srand((unsigned)time(NULL));
  for(nor=0;nor<NUMRUNS;nor++) {
	  /* create a population of size 100 x 4 X 2 with random double values in the range 0 and 1
	   * Here 100 is the size of the population
	   * 4  is the dimension size
	   * 2  is the number of clusters
	   */
     for(d=0;d<2;d++) {
		 for(i=0;i<ROWS;i++) {
		     for(j=0;j<COLS;j++) {
			     x= (float) (rand() / (RAND_MAX+1.0)); 
				 temp[d][i][j]=x;
			 }
		 }
     }
     numGen = 0;

	 /* lets say the firt chromosome is i which is pointing to 0th chromosome in the population.
	  * randomly select 3 chrmosomes from the remaining i-1 chromosomes.
	  * name them as a , b and c   (i != a != b != c)
      *  Here a, b and c have the same number of clusters as 'i'   i.e 2
	  */
     i = 0;
     finalFitness = retFinFit(temp[0][i],temp[1][i],COLS);
     while(finalFitness > 0.001 && numGen < 200) {
	  printf(".");
	  for(i=0;i<ROWS;i++) {
	      fflush(stdin);
	      oldfit  = 0.0;
	      fitness = 0.0;


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


	      oldfit = retFinFit(temp[0][i],temp[1][i],COLS);
	      for(d=0;d<2;d++) {
		  for(j=0;j<COLS;j++) {
		      temp1[d][j] = temp[d][a][j] + f*(temp[d][b][j] - temp[d][c][j]);
		  }
	      }
	      for(d=0;d<2;d++) {
		  for(j=0;j<COLS;j++) {
		      temps[d][j]=((double) 1* rand()/ (RAND_MAX)<0.8)?temp1[d][j]:temp[d][i][j];
		  }
	      }

	      fitness = retFinFit(temps[0],temps[1],COLS);

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

	   for(j=0;j<ROWS;j++) {
		fitnessVals[j] = retFinFit(finalPop[0][j],finalPop[1][j],COLS);
	   }

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
	   if(nor == 0) {
	       printf("::Output for First Run::\n");
	       printf("\nMaxFitness   GenerationNumber  MinFinalFitness \n");
	       printf("*****************************************\n");
	       for(m=1;m<numGen;m++) {
		   if(m%20 == 0){
			printf("%lf \t %d \t\t %lf \n",MaxFinalFitness(finalFitnessVals,m),m,finalFitnessVals[m]);
		   }
	       }
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
