graph = {}
path = []
pc = 0
frontier_q = []
explored = []
cpc = 0


def create_graph():
    # read file contents
    array_list = []
    with open('graph.txt') as inp_file:
        global source, dest
        for line in inp_file:
            array_list = []
            words = line.split(",")
            source = words[0]
            dest = words[1]
            w = int(words[2])

            vertex = (dest, w)

            # checking if the node already exists in graph dictionary
            if source in graph.keys():
                array_list = graph[source]
                array_list.append(vertex)
                graph[source] = array_list
            else:
                array_list.append(vertex)
                graph[source] = array_list

            # reverse path
            vertex = (source, w)
            array_list = []
            if dest in graph.keys():
                array_list = graph[dest]
                array_list.append(vertex)
                graph[dest] = array_list
            else:
                array_list.append(vertex)
                graph[dest] = array_list


def show_graph():
    print("Following is the given graph:-")
    for key, value in graph.items():
        show = str(key) + " : " + str(value)
        print(show)


def initialize():
    global path, pc, frontier_q, explored
    path = []
    pc = 0
    frontier_q = []
    explored = []
    return


def test_goal():
    global curr_node, dest
    if curr_node == dest:
        return 1
    else:
        return 0


def update_frontier(algo):
    global curr_node, dest, source
    global path, pc, frontier_q, explored, cpc, clength

    if curr_node not in explored:
        for row in graph[curr_node]:
            if row not in frontier_q:
                r0 = row[0]
                r1 = curr_node
                r2 = row[1]

                if algo == "UCS":
                    r2 = r2 + cpc

                rows = (r0, r1, r2)
                frontier_q.append(rows)

        explored.append(curr_node)

        frontier_q = [x for x in frontier_q if x[0] not in explored]
        if algo == "UCS":
            frontier_q.sort(key=lambda x: x[2])
    return


def choose_node(algo):
    global curr_node, dest, source
    global path, pc, frontier_q, explored, cpc

    if algo in ["BFS", "UCS"]:
        popped = frontier_q[0]
        if algo == "UCS":
            cpc = popped[2]
        curr_node = popped[0]
        frontier_q = frontier_q[1:]
        path.append(popped)

    elif algo == "DFS":
        popped = frontier_q.pop()
        curr_node = popped[0]
        path.append(popped)
    return cpc


def cal_path():
    global path, pc
    i = 0
    pc = 0
    reverse_p = []
    path.reverse()

    tup = path[0]
    reverse_p.append(tup[0])
    iparent = tup[1]
    pc = pc + tup[2]
    i += 1

    while i < len(path):
        a = path[i]
        if a[0] == iparent:
            reverse_p.append(a[0])
            iparent = a[1]
            pc = pc + a[2]
        i += 1

    reverse_p.reverse()
    path = reverse_p
    return


def graph_search(algo):
    global curr_node, dest, source
    global path, pc, frontier_q, explored

    if algo in ["DFS", "BFS"]:
        initialize()
        path.append((source, source, 0))
        curr_node = source
        result = 0

        while True:
            test = test_goal()
            if test == 1:
                result = 1
                res = path
                break
            if algo == "BFS":
                update_frontier("BFS")
            elif algo == "DFS":
                update_frontier("DFS")

            if len(frontier_q) == 0:
                res = "Source and Destination are not connected."
                result = 0
                break
            if algo == "BFS":
                choose_node("BFS")
            else:
                choose_node("DFS")
        cal_path()
        if result == 1:
            res.reverse()
    else:
        initialize()
        path.append((source, source, 0))
        cpc = 0
        curr_node = source
        result = 0

        while True:
            test = test_goal()
            if test == 1:
                result = 1
                res = path
                break
            update_frontier("UCS")
            if len(frontier_q) == 0:
                res = "Source and Destination not connected."
                result = 0
                break
            cpc=choose_node("UCS")
        cal_path()
        pc = cpc

        if result == 1:
            res.reverse()
    return res

if __name__ == "__main__":
    create_graph()
    show_graph()
    print "Choose a Searching algorithm:(BFS/DFS/UCS)"
    algo = raw_input()
    if algo not in ["BFS", "DFS", "UCS"]:
        print "Wrong Algorithm"
        exit()
    print "Enter the source node:"
    source = raw_input()
    if source not in graph.keys():
        print "City doesn't exist!"
        exit()
    curr_node = source
    print "Enter the destination node:"
    dest = raw_input()
    if dest not in graph.keys():
        print "City doesn't exist!"
        exit()
    traversal = graph_search(algo)
    print"-----------",
    print algo,
    print "Result----------"
    print "Traversal:"
    print traversal
    print("path :")
    for i in range(len(path)):
        if i == 0:
            print path[i],
        else:
            print "-> %s" % path[i],
    print ""
    print "path cost :",
    print pc
