addpath("octave");

%import the muxOctaveLib
muxOctaveLib;

%import the configuration file
LayersList = {};
muxOctaveConfig;

NodesTensor = {}; 
Layers = 0;
[NodesTensor,Layers,Nodes] = BuildMultiplexFromFileList(LayersList,Flags,MaxNodes,FirstNodeLabel);
                
LayersTensor = BuildLayersTensor(Layers,Nodes,OmegaParameter,MultisliceType);
        
SupraAdjacencyMatrix = BuildSupraAdjacencyMatrix(NodesTensor,LayersTensor,Layers,Nodes);

% Calculate the centralities

CentralityVector = GetMultiInDegreeSum(SupraAdjacencyMatrix,Layers,Nodes,Flags);
outputFile = strcat(AnalysisName,"_centrality_indegree.txt");
dlmwrite (outputFile, CentralityVector, 'delimiter',' ')
printf("Multislice centrality output to: %s\n",outputFile);

#aggregate
Aggregate = GetAggregateMatrix(NodesTensor,Layers,Nodes);
CentralityVector = GetMultiInDegreeSum(Aggregate,1,Nodes,Flags);
outputFile = strcat(AnalysisName,"_centrality_indegree_aggregate.txt");
dlmwrite (outputFile, CentralityVector, 'delimiter',' ')
printf("Multislice centrality output to: %s\n",outputFile);
