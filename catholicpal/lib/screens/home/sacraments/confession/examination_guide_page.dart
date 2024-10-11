import 'package:catholicpal/models/confession_model.dart';
import 'package:catholicpal/providers/confession_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ExaminationGuideContent extends StatelessWidget {
  const ExaminationGuideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examination of Conscience'),
      ),
      body: const Column(
        children: [
          LifeStageDropdown(),
          SearchBar(),
          Expanded(
            child: AreasList(),
          ),
          ProgressIndicator(),
          ClearHistoryButton(),
        ],
      ),
    );
  }
}

class LifeStageDropdown extends StatelessWidget {
  const LifeStageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        return DropdownButton<String>(
          value: provider.selectedLifeStage,
          onChanged: (String? newValue) {
            if (newValue != null) {
              provider.setSelectedLifeStage(newValue);
            }
          },
          items: provider.categories
              .map<DropdownMenuItem<String>>((LifeStageCategory category) {
            return DropdownMenuItem<String>(
              value: category.name,
              child: Text(category.name),
            );
          }).toList(),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        return TextField(
          onChanged: provider.setSearchQuery,
          decoration: const InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        );
      },
    );
  }
}

class AreasList extends StatelessWidget {
  const AreasList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        List<ExaminationArea> areas =
            provider.getFilteredAreas(provider.selectedLifeStage);
        return ListView.builder(
          itemCount: areas.length,
          itemBuilder: (context, index) {
            return AreaExpansionTile(area: areas[index]);
          },
        );
      },
    );
  }
}

class AreaExpansionTile extends StatelessWidget {
  final ExaminationArea area;

  const AreaExpansionTile({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(area.name),
      children: area.checkpoints
          .map((checkpoint) => CheckpointTile(
              areaName: area.name,
              checkpoint: checkpoint)) // Pass area name here
          .toList(),
    );
  }
}

class CheckpointTile extends StatelessWidget {
  final String areaName; // Add the area name here
  final Checkpoint checkpoint;

  const CheckpointTile(
      {super.key,
      required this.areaName,
      required this.checkpoint}); // Include areaName in constructor

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        return CheckboxListTile(
          title: Text(checkpoint.question),
          value: checkpoint.isChecked,
          onChanged: (bool? value) {
            if (value != null) {
              provider.updateCheckpoint(
                provider.selectedLifeStage,
                areaName, // Now use areaName instead of 'area.name'
                checkpoint.question,
                value,
              );
            }
          },
        );
      },
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        double progress = provider.getProgress(provider.selectedLifeStage);
        return LinearProgressIndicator(value: progress);
      },
    );
  }
}

class ClearHistoryButton extends StatelessWidget {
  const ClearHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExaminationProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          onPressed: provider.clearAllCheckpoints,
          child: const Text('Clear History'),
        );
      },
    );
  }
}
