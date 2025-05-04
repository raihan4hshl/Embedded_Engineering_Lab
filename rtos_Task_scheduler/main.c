#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct {
    int id;
    int wcet;
    int deadline;
    int remaining_time;
    int completed;
} Task;

int main() {
    Task tasks[] = {
        {1, 2, 6, 2, 0},
        {2, 1, 3, 1, 0},
        {3, 1, 7, 1, 0},
        {4, 2, 9, 2, 0}
    };

    int time = 0;
    int num_tasks = sizeof(tasks) / sizeof(Task);

    printf("EDF Scheduling Simulation:\n");

    while (1) {
        // Sort tasks by deadline
        for (int i = 0; i < num_tasks - 1; i++) {
            for (int j = i + 1; j < num_tasks; j++) {
                if (tasks[i].deadline > tasks[j].deadline) {
                    Task temp = tasks[i];
                    tasks[i] = tasks[j];
                    tasks[j] = temp;
                }
            }
        }

        int task_run = 0;
        for (int i = 0; i < num_tasks; i++) {
            if (!tasks[i].completed && tasks[i].remaining_time > 0) {
                printf("Time %d: Running Task T%d\n", time, tasks[i].id);
                tasks[i].remaining_time--;
                task_run = 1;

                if (tasks[i].remaining_time == 0) {
                    tasks[i].completed = 1;
                    printf("Task T%d completed at time %d\n", tasks[i].id, time + 1);
                }
                break;
            }
        }

        if (!task_run) {
            break; // All tasks done
        }

        sleep(1); // Simulate time passage (optional)
        time++;
    }

    printf("All tasks completed.\n");
    return 0;
}
