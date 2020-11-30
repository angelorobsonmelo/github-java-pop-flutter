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
              return Container(
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 46),
                    separatorBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final repository = snapshot.data[index];
                      return buildRepositoriesList(repository);
                    }),
              );
          },
        ),
      ),
    );
  }

  InkWell buildRepositoriesList(GitRepository repository) {
    return InkWell(
      child: Container(
        height: 110,
        margin: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [firstSession(repository), secondSession(repository)],
        ),
      ),
      onTap: () {},
    );
  }

  Column firstSession(GitRepository repository) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 250,
          child: Text(
            repository.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 4),
            width: 250,
            child: Text(
              repository.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        buildContainerIcons(repository)
      ],
    );
  }

  Container buildContainerIcons(GitRepository repository) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            child: Image(
              image: AssetImage('images/icon_fork.png'),
              color: Colors.black87,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            height: 24,
            child: Text(repository.forksCount.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87)),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            height: 24,
            width: 24,
            child: Icon(
              Icons.star,
              color: Colors.black87,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            height: 24,
            child: Text(
              repository.forksCount.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }

  Column secondSession(GitRepository repository) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(repository.owner.avatarUrl),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 85,
          alignment: Alignment.center,
          child: Text(
            repository.owner.login,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        )
      ],
    );
  }
}
