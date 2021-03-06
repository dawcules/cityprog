import 'package:cityprog/model/carpool.dart';
import 'package:cityprog/model/market.dart';
import 'package:cityprog/strings/widget_texts.dart';
import 'package:cityprog/styles/color_palette.dart';
import 'package:cityprog/widgets/columns/user_info_column.dart';
import 'package:cityprog/widgets/database_model/auth.dart';
import 'package:cityprog/widgets/database_model/database.dart';
import 'package:cityprog/widgets/lists/votingListTile.dart';
import 'package:cityprog/widgets/posts/carpool_post.dart';
import 'package:cityprog/widgets/posts/carpool_post_modal.dart';
import 'package:cityprog/widgets/posts/community_post_modal.dart';
import 'package:cityprog/widgets/posts/market_post.dart';
import 'package:cityprog/widgets/posts/market_post_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth/data/classes/auth_user.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final AuthUser _user = Auth().getUser();
  List<Widget> posts = [];
  bool fetchingPosts = true;
  int _citizenPoints;

  void _getUserPosts() async {
    List<DocumentSnapshot> marketPosts;
    List<DocumentSnapshot> carpoolPosts;
    List<DocumentSnapshot> votes;
    String uid = Auth().getUID();
    Database().getAllPostsByUser(uid).then(
          (value) => {
            setState(() => fetchingPosts = false),
            marketPosts = value["marketPosts"],
            carpoolPosts = value["carpoolPosts"],
            votes = value["votes"],
            marketPosts.forEach((element) {
              MarketPostData mpd = MarketPostData.fromMap(element.data);
              setState(
                () => posts.add(
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 16, left: 16),
                    child: MarketPostWidget(
                      mpd,
                      () => _onMorePressedMarketplace(mpd),
                    ),
                  ),
                ),
              );
            }),
            carpoolPosts.forEach(
              (element) {
                CarpoolPostData cpd = CarpoolPostData.fromMap(element.data);
                setState(
                  () => posts.add(
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 16, left: 16),
                      child: CarpoolPostWidget(
                        cpd,
                        () => _onMorePressedCarpool(cpd),
                      ),
                    ),
                  ),
                );
              },
            ),
            votes.forEach((element) {
              print(element.data["votedFor"]);
              element.data["votedFor"].forEach((it) => {
                    if (it[Auth().getUID()] != null)
                      {
                        setState(() => posts.add(createVoteString(
                            it[Auth().getUID()], element.data)))
                      }
                  });
            })
          },
        );
  }

  Widget createVoteString(int vote, Map<String, dynamic> voteData) {
    String voteWidgetString;
    switch (vote) {
      case 0:
        voteWidgetString = LocalizedWidgetStrings.votedYesToLocalized();
        break;
      case 1:
        voteWidgetString = LocalizedWidgetStrings.votedNoToLozalized();
        break;
      default:
        voteWidgetString = LocalizedWidgetStrings.votedNoToLozalized();
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
      child: VotingListTile(
        index: voteData,
        hasAlreadyVoted: null,
        update: () => null,
        voteAgainst: () => null,
        voteFor: () => null,
        hideVoteRow: true,
        voteRowReplacement: Text(
          voteWidgetString,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "RadicalLight",
            color: vote == 0 ? Colors.green : Colors.red
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getPoints();
    _getUserPosts();
  }

  void _getPoints() {
    Database().getUserCitizenpoints(user: _user.uid).then((value) =>
        {setState(() => _citizenPoints = value.data["citizenpoints"])});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              height: 1000,
              width: 750,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80),
                child: Column(children: [
                  Padding(padding: EdgeInsets.all(8)),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: UserInfoColumn(
                            name: _user.displayName,
                            citizenPoints: _citizenPoints,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Text(
                          LocalizedWidgetStrings.yourActivityToLocalized(),
                          style: TextStyle(
                              fontSize: 16, color: AppColor.secondary.color()),
                        ),
                      )
                    ],
                  ),
                  fetchingPosts
                      ? CircularProgressIndicator()
                      : Column(
                          children: posts,
                        )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onMorePressedCarpool(CarpoolPostData post) {
    showDialog(
        context: context,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: CommunityPostModal(
              CarpoolPostModal(post),
              title: post.title,
            )));
  }

  void _onMorePressedMarketplace(MarketPostData post) {
    showDialog(
        context: context,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: CommunityPostModal(
              MarketPostModal(post),
              title: post.title,
            )));
  }
}
