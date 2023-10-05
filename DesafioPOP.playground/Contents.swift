import UIKit

// Protocolo para representar uma tarefa
protocol TaskProtocol {
    var title: String { get }
    var isCompleted: Bool { get set }
}

// Protocolo para gerenciar a lista de tarefas
protocol TaskManagerProtocol {
    var tasks: [TaskProtocol] { get }
    func addTask(title: String)
    func listTasks()
    func completeTask(at index: Int)
}

// Implementação da struct que conforma ao protocolo TaskProtocol
struct Task: TaskProtocol {
    var title: String
    var isCompleted: Bool
}

// Implementação da classe que conforma ao protocolo TaskManagerProtocol
class TaskManager: TaskManagerProtocol {
    var tasks: [TaskProtocol] = []

    func addTask(title: String) {
        let task = Task(title: title, isCompleted: false)
        tasks.append(task)
    }

    func listTasks() {
        for (index, task) in tasks.enumerated() {
            let status = task.isCompleted ? "Concluída" : "Pendente"
            print("\(index + 1). \(task.title) - \(status)")
        }
    }

    func completeTask(at index: Int) {
        if index >= 0 && index < tasks.count {
            tasks[index].isCompleted = true
            print("Tarefa marcada como concluída.")
        } else {
            print("Índice inválido.")
        }
    }

    // Função assíncrona para simular concorrência
    func simulateConcurrency() {
        let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)

        concurrentQueue.async {
            self.addTask(title: "Tarefa 1")
            self.listTasks()
        }

        concurrentQueue.async {
            self.addTask(title: "Tarefa 2")
            self.listTasks()
        }

        concurrentQueue.async {
            self.completeTask(at: 0)
            self.listTasks()
        }

        concurrentQueue.async {
            self.completeTask(at: 1)
            self.listTasks()
        }
    }
}

// Criando uma instância do gerenciador de tarefas
let taskManager = TaskManager()

// Adicionando tarefas
taskManager.addTask(title: "Comprar leite")
taskManager.addTask(title: "Fazer exercícios")

// Listando tarefas
print("Lista de Tarefas:")
taskManager.listTasks()

// Marcar tarefas como concluídas
taskManager.completeTask(at: 0)
taskManager.completeTask(at: 2)

// Listando tarefas novamente
print("\nLista de Tarefas Atualizada:")
taskManager.listTasks()

// Simulando concorrência
taskManager.simulateConcurrency()

