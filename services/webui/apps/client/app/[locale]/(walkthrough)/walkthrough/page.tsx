"use client";

import Image from "next/image";
import { useState } from "react";
import { useRouter } from "next/navigation";

const Walkthrough = () => {
  const [step, setStep] = useState(0);
  const router = useRouter();

  const slides = [
    {
      image: "/tutorial/tutorial-welcome.gif",
      title: "Welcome to FRIENDSHIP. DAO",
      description:
        "FRIENDSHIP.DAOへようこそ！\n\n簡単にFRIENDSHIP.DAOでできることを説明します。",
    },
    {
      image: "/tutorial/tutorial-services.gif",
      title: "HOME",
      description:
        "Homeでは、OffersやDashboardのサマリーを確認できます。また、あなたの活動や音楽の視聴数などに応じて、アクションの提案をおすすめします。",
    },
    {
      image: "/tutorial/tutorial-offer.gif",
      title: "OFFERS",
      description:
        "Offersでは、あなたにあったオファーを探すことができ、オファーに応募して承認されると、オファー作成者やオファーのパートナーと共に、オファーを始めることになります。オファーを完了すると、ポイントが付与されます。",
    },
    {
      image: "/tutorial/tutorial-dashboard.gif",
      title: "DASHBOARD",
      description:
        "Dashboardでは、登録された音楽チャンネルの再生数を統合し、あなたのアーティストとしての活動を可視化します。週、月での再生数の確認、再生されているユーザーや国の内訳などあなたにとって有益な情報が確認できます。",
    },
    {
      image: "/tutorial/tutorial-community.gif",
      title: "COMMUNITY",
      description:
        "Communityでは、繋がった他のユーザーとの繋がりを確認できます。また、繋がったユーザーのユーザーページを確認し、そのユーザーの繋がりを確認することもできます。気になったユーザーがいたら、メッセージを送って繋がりましょう。",
    },
  ];

  const handleNext = () => {
    if (step < slides.length - 1) {
      setStep(step + 1);
    } else {
      localStorage.setItem("walkthroughCompleted", "true");
      router.push("/");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen relative">
      <div className="flex gap-12 items-stretch max-w-6xl w-full px-8">
        <div className="w-1/2">
          <Image
            src={slides[step]?.image || ""}
            alt={`Step ${step + 1}`}
            width={750}
            height={750}
            className="w-full rounded-2xl"
          />
        </div>

        <div className="w-1/2 flex flex-col justify-between min-h-[500px]">
          <div className="w-full flex justify-end">
            {step < slides.length - 1 && (
              <button
                onClick={() => router.push("/")}
                className="text-[14px] font-light decoration-dashed underline"
              >
                スキップする
              </button>
            )}
          </div>

          <div className="flex flex-col items-start">
            <h1
              className={`font-light leading-none mb-8 ${
                step === 0 ? "text-[90px]" : "text-[60px]"
              }`}
            >
              {slides[step]?.title || ""}
            </h1>
            <p className="text-[14px] font-light mt-2 leading-normal whitespace-pre-line mb-8 w-[480px]">
              {slides[step]?.description || ""}
            </p>
            <div className="flex gap-4">
              {step > 0 && (
                <button
                  onClick={() => setStep(step - 1)}
                  className="text-black bg-white border-2 border-[#E4DBC0] hover:bg-gray-50 w-[180px] h-[60px] text-[14px] rounded-full"
                >
                  戻る
                </button>
              )}
              <button
                onClick={handleNext}
                className={`text-black bg-[#E4DBC0] hover:bg-[#E4DBC0]/90 rounded-full ${
                  step === 0
                    ? "w-[270px] h-[90px] text-[18px]"
                    : "w-[180px] h-[60px] text-[14px]"
                }`}
              >
                {step < slides.length - 1 ? "次へ" : "はじめる"}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Walkthrough;
