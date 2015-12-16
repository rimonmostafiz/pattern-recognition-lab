#include <bits/stdc++.h>

#define EPS 1e-6

using namespace std;

struct Point
{
    double x,y;
};

Point points[1000];
Point cluster[100];
Point s[1000];

int k=5;

double dist(Point a, Point b)
{
    double p = (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
    return sqrt(p);
}

int main()
{
    //freopen("out.txt", "w", stdout);

    //Randomly generate 50 points
    for(int i = 0; i < 50; i++)
    {
        points[i].x = rand()%1000;
        points[i].y = rand()%1000;
        //printf("%f %f\n", points[i].x, points[i].y);
    }
    double m = 1e7 + 10;
    for(int i = 0; i < 10; i++)
    {
        //Generate K cluster centroid points.
        for(j=0; j<k; j++)
        {
            cluster[j].x = rand()%1000;
            cluster[j].y = rand()%1000;
        }

        double d = 0.0;
        for(int p=0; p<50; p++)
        {

            double minimum = 1e7 + 10;
            double d1 = 0.0;

            for(int q = 0; q < k; q++)
            {
                Point a, b;
                a.x = cluster[q].x;
                a.y = cluster[q].y;

                b.x = points[p].x;
                b.y = points[p].y;

                d1 = dist(a, b);
                if(minimum > d1 + EPS)
                {
                    minimum = d1;
                }
            }
            d += minimum;
        }
        printf("d = %f\n", d);
        if(m > d + EPS)
        {
            m = d;
            printf("m = %f\n", m);
            for(int t=0; t<k; t++)
            {
                s[t].x = cluster[t].x;
                s[t].y = cluster[t].y;
            }
        }
    }
    printf("\n");
    for(j=0; j<k; j++)
    {
        printf("Claster is (%f ,%f)\n",s[j].x,s[j].y);
    }
    printf("\n");
    for(int i = 0; i < 50; i++)
    {
        double dst = 0.0;
        double mini = 1e7 + 10;
        int idx = -1;
        for(int j = 0; j < k; j++)
        {
            Point a, b;
            a.x = s[j].x;
            a.y = s[j].y;

            b.x = points[i].x;
            b.y = points[i].y;

            dst = dist(a, b);
            if(mini > dst + EPS)
            {
                mini = dst;
                idx = j;
            }
        }
        printf("Point %2d (%.2f, %.2f) is under Claster %d (%.2f, %.2f)\n", i, points[i].x, points[i].y, idx, s[idx].x, s[idx].y);
    }
    return 0;
}

