import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/ui/gitrepositories/bloc/git_repository_bloc.dart';

class GitRepositoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GitRepositoryBloc>(context);

    bloc.getRepositories();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Github JavaPop'),
          backgroundColor: Colors.black87,
        ),
        body: StreamBuilder(
          stream: bloc.outGitRepositories,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.isEmpty)
              return Center(child: CircularProgressIndicator());
            else
              return ListView.separated(
                  separatorBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Divider(
                          color: Colors.black87,
                        ),
                      ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final repository = snapshot.data[index];
                    return buildRepositoriesList(repository);
                  });
          },
        ),
      ),
    );
  }

  InkWell buildRepositoriesList(GitRepository repository) {
    return InkWell(
      child: SizedBox(
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(repository.name),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(repository.owner.avatarUrl),

                      ),
                      Text(repository.owner.login)
                    ],
                  )
                ]),
            Container(
              width: 100,
              child: Text(repository.description,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                Icon(Icons.add),
                Text(repository.forksCount.toString()),
                SizedBox(
                  width: 15,
                ),
                Icon(Icons.login),
                Text(repository.stargazersCount.toString())
              ],
            )
          ],
        ),
      ),
      onTap: () {

      },
    );
  }
}
